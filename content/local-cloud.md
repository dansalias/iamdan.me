+++
date = 2025-08-05
title = "Local Cloud Emulation"

[extra]
hn = 44940393
+++

Simulating production environments locally often results in a collection of
opaque containers and third-party "local cloud" emulators. This is a symptom of
the system adapting to fit the cloud, rather than the other way 'round.

The goal shouldn't be to mimick the production environment as closely as
possible---staging or multiple production mirrors serve this purpose---but
rather to enable the best possible local development experience (typified by
transparency and instant feedback).

Adopting a _local first_ approach not only improves DX, but also engenders a
more flexible, cloud-agnostic system. This can be achieved by building in-memory
versions of platform services. While daunting at first, it ends up being much
simpler than expected.

Here's an in-memory event bus in 24 lines of TypeScript:

```ts
import { MessageBus } from '@/adapters'

export class LocalMessageBus implements MessageBus {
  private subscribers: Map<
    Platform.Messages.Topic,
    Platform.Messages.MessageHandler[]
  > = new Map()

  subscribe(
    topic: Platform.Messages.Topic,
    handler: Platform.Messages.MessageHandler,
  ): void {
    this.subscribers.set(
      topic,
      (this.subscribers.get(topic) || []).concat(handler),
    )
  }

  publish(message: Platform.Messages.Message): void {
    for (const handler of this.subscribers.get(message.meta.topic || [])) {
      handler(message)
    }
  }
}
```

Common patterns such as databases, file storage and API gateways are equally
trivial.

This approach encourages dependency injection and abstracting away vendor APIs:

```ts
import { MessageBus } from '@/adapters'

export const broadcast = (messageBus: MessageBus, message: Message) => {
  messageBus.publish(event)
}
```

Production adapters implement the same interfaces as local adapters:

```ts
export interface MessageBus {
  publish: (message: Platform.Messages.Message) => void | Promise<void>
  subscribe: (
    topic: Platform.Messages.Topic,
    handler: Platform.Messages.MessageHandler,
  ) => void | Promise<void>
}
```

```ts
import { MessageBus } from '@/adapters'
import {
  SNSClient,
  PublishCommand,
  SubscribeCommand,
} from '@aws-sdk/client-sns'

const client = new SNSClient({})

export class AWSMessageBus implements MessageBus {
  async publish(message: Platform.Messages.Message): Promise<void> {
    await client.send(
      new PublishCommand({
        TopicArn: this.getTopicArn(topic),
        Message: JSON.stringify(message),
      }),
    )
  }

  async subscribe(
    topic: Platform.Messages.Topic,
    handler: Platform.Messages.MessageHandler,
  ): Promise<void> {
    await client.send(
      new SubscribeCommand({
        TopicArn: this.getTopicArn(topic),
        Protocol: 'lambda',
        Endpoint: this.getHandlerArn(handler),
      })
    )
  }

  // arn helpers redacted
}
```

And across a project this looks like:

```
platform
├── adapters
│   ├── api-gateway.ts
│   ├── database.ts
│   ├── message-bus.ts
│   └── ...
└── environments
    ├── cloud
    │   └── aws
    │       ├── api-gateway.ts
    │       ├── database.ts
    │       ├── message-bus.ts
    │       └── ...
    └── local
        ├── api-gateway.ts
        ├── database.ts
        ├── message-bus.ts
        └── ...
```

Local integration and end-to-end testing is now much simpler.

Introducing auxillary functionality such as logging is trivial:

```ts
export interface Logger {
  log: (message: string) => void | Promise<void>
}
```

```ts
import { Logger } from '@/adapters'

export class LocalLogger implements Logger {
  log(message) {
    console.log(message)
  }
}
```

And shifting left on production logging is encouraged at the same time:

```ts
import { Logger } from '@/adapters'
import {
  CloudWatchLogsClient,
  PutLogEventsCommand,
} from "@aws-sdk/client-cloudwatch-logs"

export class AWSLogger implements Logger {
  private client: CloudWatchLogsClient

  async log(message) {
    await client.send(new PutLogEventsCommand({
      logGroupName: process.env.AWS_LOG_GROUP_NAME,
      logStreamName: process.env.LOG_STREAM_NAME,
      logEvents: [{
        message,
        timestamp: Date.now(),
      }]
    }))
  }
}
```

The code and mindset shift from cloud APIs as a base layer to the cloud as a
_dependency_ is powerful, and many of these "shift left" opportunities present
themselves once the local environment becomes the reference platform
implementation.

Try it out!

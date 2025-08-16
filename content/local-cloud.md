+++
date = 2025-08-05
title = "Local Cloud Emulation"
+++

Mimicking production environments locally is often attempted by stringing
together a bunch of opaque containers and third-party "local cloud" tools.

It's worth exploring simply creating in-memory versions of platform services
instead. While daunting at first, it ends up being much simpler than expected.

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

<!--
You can add logging for transparent real-time development:

```ts
// ...
```

And shift left on production logging at the same time:

```ts
// ...
```

The code and mindset shift from cloud APIs as a base layer to the cloud as a
_dependency_ is powerful, and many of these "shift left" opportunities present
themselves once you own the platform and can take advantage of the speed of local
development.
-->


Try it out!

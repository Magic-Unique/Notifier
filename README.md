# Notifier

[中文说明](./README.zh_CN.md)

Notifier is a command line tool to send a notification. It provide some apis with different user interface.



# Features

1. Notification with message body

2. Notification with title, subtilte body

3. Notification with icon (On left of the notification banner)

4. Notification with image (On right of the notification banner)

5. Notification with one or more action button

6. Notification with reply text field

7. Notification with sounds

8. Notification with specially Application

9. Notification with auto-hide after delay

# Install

1. Download this repo
2. Build `Notify (Release)` scheme in Xcode
3. Typin `$ notify --help` to get help banner

# Usage

### Base - Only Message

Post a notification with a message body

```shell
$ notify "This is the message body"
```

And get banner:

![](Resources/base.png)

----

### Base: More information

Post a notification with title, subtitle, message

```shell
$ notify "This is the message body" --title "title" --subtitle "subtitle"
```

And get banner:

![](Resources/base-title.png)

---

### Action: One Action

Post a notification with an action button and a close button

```shell
ACTION=$(notify 'Do u want to continue?' --action 'YES' --close 'NO')
```

And get banner:

![](Resources/action-one.png)

After user choose, command line will print action title and return. For example:

```shell
ACTION=$(notify 'Do u want to continue?' --action 'YES' --close 'NO')
if [[ "${ACTION}" == "YES" ]]; then
    echo 'You click YES'
else
    echo 'You click NO'
fi
```

---

### Action: More Action

Post a notificaiton with two or more action buttons and a close button

```shell
ACTION=$(notify 'What do you want?' --action 'Coffee' --action 'Tea' --action 'Milk' --menu 'Menu')

## typin more --action 'TITLE' to insert more button
## typin --menu 'TITLE' to special dropdown button title

if [[ "${ACTION}" == "Cofee" ]]; then
    echo 'You want to a cup of coffee!'
elif [[ "${ACTION}" == "Tea" ]]; then
    echo 'You want to a cup of tea!'
elif [[ "${ACTION}" == "Milk" ]]; then
    echo 'You want to a cup of milk!'
else
    echo "Thanks!"
fi
```

And get banner:

![](Resources/action-more.png)

---

### Action: Reply Action

Post a notification with a reply text field

```shell
ACTION=$(notify 'Steve: Go tomorrow?' --reply 'Reply Steve')
if [[ "${ACTION}" == "close" ]]; then
    echo 'You dont say anything to Steve'
else
    echo "You said '${ACTION}'"
fi
```

And get banner:

![](Resources/action-reply.png)

---

### Media: Icon & Image

Post a notification with a spically icon or an image

```shell
$ notify 'Message' --icon './icon.png' --image './image.png'
```

And get banner:

![](Resources/media-image.png)

---

### Media: Sound

Post a notification with sound

```shell
$ notify 'Message' --sound 'default' # post with a ringing
```

---

### Timeout

Post a notification and auto hide after delay.

```shell
ACTION=$(notify 'Some error, repeat?' --action 'YES' --close 'NO' --timeout 5)
if [[ "${ACTION}" == "timeout" ]]; then
    echo 'You did not choose anything'
fi
```

---

### Application

Post a notification with a specially application

```shell
$ notify 'Download succeed!' --sender 'com.apple.finder'
```

And get banner:

![](Resources/sender.png)

---

# LICENSE

MIT.



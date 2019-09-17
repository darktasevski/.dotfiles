# Mac OSX setup checklist

- Update OSX
- Set up ssh and gpg keys for Github/Gitlab
- Install Chrome, Password manager, Alfred, Dropbox, Teams/Slack, Webstorm + Webstorm settings
- Download .fonts and ngrok

## Installing ngrok on OSX

1. [Download ngrok](https://ngrok.com/download)
2. Unzip it to your Applications directory
3. Create a symlink (instructions below)

### Creating a symlink to ngrok
Run the following two commands in Terminal to create the symlink.
```shell
# cd into your local bin directory
cd /usr/local/bin

# create symlink
ln -s /Applications/ngrok ngrok
```

This will allow you to run the `ngrok` command from any directory while in the terminal. Without the symlink, you would need to either `cd` into the Applications directory (or wherever you installed the executable) or reference ngrok with its full path every time (e.g. `/Applications/ngrok 5000`)

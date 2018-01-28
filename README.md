To setup this container:

- `git clone git@github.com:aaroncox/docker-sirius.git docker-sirius`
- `cd docker-sirius`
- `git submodule update --init --recursive`
- `docker build -t sirius .`
- `docker run --rm -d -v /root/sirius/wallet:/root/.sirius --name sirius sirius`

The container will now start sirius and the `wallet` folder will contain everything that is typically in the home folder for your daemon. You can monitor `wallet/debug.log` to see the status of the blockchain sync.

Any command that you'd like to execute against `sirius-cli` can be done via:

`docker exec -it sirius sirius-cli [command]`

For example:

`docker exec -it sirius sirius-cli getinfo`

To unlock your wallet for staking:

```
$ docker exec -it sirius sirius-cli -stdin walletpassphrase
[type password and hit enter]
[type time to remain unlocked and hit enter]
true
[Press CTRL+D to complete the input sequence]
```

Within a minute or so, your wallet should display `"staking": true` and `"enabled": true`. You can check on these values by running:

`docker exec -it sirius sirius-cli getstakinginfo`

If you'd like to continiously tail/watch your staking activity:

`watch "docker exec -it sirius sirius-cli getstakinginfo && docker exec -it sirius sirius-cli getwalletinfo"`

To stop the container:

`docker exec -it sirius sirius-cli stop`

or

`docker stop sirius`

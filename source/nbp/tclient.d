module nbp.tclient;
import nbp;
import vibeirc;
import vibe.core.core;
import std.math;

import std.stdio : writeln, writefln;
import core.time;

/**
    The twitch client
*/
__gshared TwitchClientImpl TwitchClient;

/**
    An IRC client that can connect to twitch
*/
class TwitchClientImpl {
private:
    IRCClient client;
    uint times;

    void onLogin() {
        times = 0;
        writeln("Logged in");

        // Join our own channel
        this.join("#"~config.nickname);
    }

    void onUserJoin(User user, string channel) {
        writeln(user.nickname, " joined ", channel);
        if (channel in channels) {
            channels[channel].onUserJoin(user);
        }
    }

    void onDisconnect(string reason) {
        uint retryTime = pow(2, times++);
        writefln("disconnected: %s - retrying in %s seconds...", reason, retryTime);
        sleep(retryTime.seconds);
        connect();
    }

public:
    /**
        Channels
    */
    TwitchChannel[string] channels;

    this() {
        client = new IRCClient;
        client.onLogin = &onLogin;
        client.onUserJoin = &onUserJoin;
        client.onDisconnect = &onDisconnect;
    }

    /**
        Joins a twitch channel
    */
    void join(string channel) {
        client.join(channel);
        channels[channel] = new TwitchChannel;
        writeln("joined ", channel);
    }

    /**
        Bans a twitch user from a channel
    */
    void ban(string channel, string nickname) {
        client.send(channel, ".ban "~nickname);
    }

    /**
        Connects to the twitch IRC network
    */
    void connect() {
        client.nickname = config.nickname;
        client.username = config.nickname;
        client.connect("irc.chat.twitch.tv", 6667, config.token);
    }
}
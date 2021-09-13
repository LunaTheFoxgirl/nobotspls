module nbp.channel;
import nbp.tclient;
import vibeirc;

/**
    Statistics kept for a channel
*/
struct ChannelStats {

    /**
        How many accounts have been banned
    */
    uint bannedAccounts;

    /**
        How many times emergency hate-raid mode has been enabled
    */
    uint emergenciesStarted;

    /**
        The amount of people who are currently being monitored by this bot
    */
    uint currentlyMonitored;
}

/**
    A twitch channel
*/
class TwitchChannel {
    /**
        Name of the twitch channel
    */
    string channel;

    /**
        List of moderators
    */
    string[] mods;

    /**
        Handle users joining the IRC channel
    */
    void onUserJoin(User user) {
        // TODO: Check user against patterns
    }

    /**
        Handle messages being recieved
    */
    void onMessageRecieved(User user, Message message) {

    }
}
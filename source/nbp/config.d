module nbp.config;
import asdf;
import std.file : readText, exists;
import std.exception;

/**
    The configuration for the bot
*/
__gshared NBPConfig config;

/**
    Loads configuration for the bot
*/
void loadConfig() {
    enforce(exists("config.json"), "No configuration found!");
    config = deserialize!NBPConfig(readText("config.json"));
}

/**
    No Bots, please configuration
*/
struct NBPConfig {
    /**
        Nickname of the bot
    */
    string nickname;

    /**
        OAuth token for the bot
    */
    string token;

    /**
        Max attempts the bot will make to reconnect to twitch in case of connection problem
    */
    @serdeOptional
    uint maxConnectAttempts = 20;
}
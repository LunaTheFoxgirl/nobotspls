import std.stdio;
import nbp;
import vibe.core.core;
import std.stdio;

void main() {
    try {

        // First load config
        loadConfig();

        // Then connect to twitch
        TwitchClient = new TwitchClientImpl;
        TwitchClient.connect();
        runApplication();
    } catch(Exception ex) {
        writeln("error: ", ex.msg);
    }
}
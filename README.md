# Godot-4-Networking

## Basic Networking Starter for Godot 4

Very basic 2D Platformer utilizing MultiplayerSpawners (spawning level and players) and MultiplayerSynchronizers (synchronizing id, position and inputs)

### Basics included

- Set up server
- Load level
- Spawn players

### Synchronization

- Sync `player:player_id` (at spawn) and `player:position`
- Sync input direction (float)
- Use `rpc` local call for jump

- Move players (local & puppet) based on synchronized input

### Future improvements

- TODO: Sync player state as one call
- TODO: Optimization, e.g. https://godotengine.org/article/multiplayer-changes-godot-4-0-report-4/#optimizations

### References

- https://godotengine.org/article/multiplayer-in-godot-4-0-scene-replication/
- https://godotengine.org/article/multiplayer-changes-godot-4-0-report-1/
- https://godotengine.org/article/multiplayer-changes-godot-4-0-report-2/
- https://godotengine.org/article/multiplayer-changes-godot-4-0-report-3/
- https://godotengine.org/article/multiplayer-changes-godot-4-0-report-4/

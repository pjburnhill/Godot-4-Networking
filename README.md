# Godot-4-Networking

## Basic Networking Starter for Godot 4

Very basic 2D Platformer utilizing MultiplayerSpawners (spawning level and players) and MultiplayerSynchronizers (synchronizing id, position and inputs)

### Basics included

- uPNP port forwarding
- Server setup
- Level load
- Spawn players
- Synchronize state (basic)

### Synchronization

- Sync `player:player_id` (at spawn) and `player:position`
- Sync `input` direction (float)
- Use `rpc` local call for jump

- Move players (local & puppet) based on synchronized input

### Future improvements

- TODO: Sync player state as one call
- TODO: Optimization, e.g. https://godotengine.org/article/multiplayer-changes-godot-4-0-report-4/#optimizations
- TOOD: Implement Channels and Ordering - https://godotengine.org/article/multiplayer-changes-godot-4-0-report-2/#channels-and-ordering
- TODO: Chat via RCP, Websocket or WebRTC
- TODO: ENet mesh networking - https://godotengine.org/article/multiplayer-changes-godot-4-0-report-3/#enet-mesh-networking

### References

- https://godotengine.org/article/multiplayer-in-godot-4-0-scene-replication/
- https://godotengine.org/article/multiplayer-changes-godot-4-0-report-1/
- https://godotengine.org/article/multiplayer-changes-godot-4-0-report-2/
- https://godotengine.org/article/multiplayer-changes-godot-4-0-report-3/
- https://godotengine.org/article/multiplayer-changes-godot-4-0-report-4/

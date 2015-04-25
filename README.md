## GodotEngine TCP test

Simple test scene to try to understand how to make godot talk to a TCP server.

To run this you need: 
- GodotEngine;
- Node.Js ( or IO.Js)

So far I can read the data I send to node, and I can send back the same data.
I currently have problems understanding the first 4 bytes of every TCP packet,
so I can't send packets from node to godot without knowing those 4 bytes beforehand.

Update: maybe I found what those first 4 bytes are: the length of the packet, without the first 4 bytes. So in a packet with 28bytes, the first 4bytes read '24', which is (28-4) the length of the packet!!

TODO: Add references to the godot wiki about binary serialization, node wiki about buffer and net.
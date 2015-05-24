## GodotEngine TCP Example

###TODO
- More datatypes to read/write 

###

Simple example scene I made while playing around trying to make godot talk to a TCP server
( I used Iojs as a TCP server).

To run this you need: 
- GodotEngine;
- Node.Js ( or IO.Js)

From Godot to Server:
- Download or clone this repo
- Open the project inside `godot_tcp` in GodotEngine, or run the `/build/godot_tcp.exe` if you use windows
- Change `host` in `node/server.js`  to match your IP (i.e. `192.168.1.6`),
- Open a terminal inside the `node` folder and run `server.js` (in nodejs: `node server.js`, in io.js: `iojs server.js`),
- Write the host and the port, like this `host:port`, 
- Click connect in the godot_tcp scene,
- Write something in the textEdit,
- Press `Send Data`,
- The string you wrote in godot_tcp should appear in the terminal, like this: `Read: <your_string>`

You can also make it reply to some hardcoded strings, like `bye` and `who am I?`

So far I can read the data I send to node, and I can send back the same data.
~~I currently have problems understanding the first 4 bytes of every TCP packet,
so I can't send packets from node to godot without knowing those 4 bytes beforehand.~~

I found out what the first 4 bytes are: the length of the packet, without 
the first 4 bytes. So in a packet with 28bytes, the first 4bytes read '24', which 
is (28-4=24) the length of the packet!
This allows me to send packets from node to godot.

References:
- https://github.com/okamstudio/godot/wiki/binary_Serialization
- https://nodejs.org/api/buffer.html
- https://nodejs.org/api/net.html

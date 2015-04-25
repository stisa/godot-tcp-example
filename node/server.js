var net = require('net')

var client_count = 0

var server = net.createServer(function(socket){
	
	client_count++
	console.log('Client number %d connected', client_count)
	socket.on('data',function(chunk){
			
			// First 4 bytes are ignored, the length of the header is 4bytes
			// NOTE: If you need different kinds of inputs, you can use the integer
			// value to differentiate data types
			var chunkType = chunk.readUIntLE(4,4) 
			
			// In strings, the bytes from 4 to 7 (n. 4,5,6,7)
			// are used to define the string length
			var chunkLength = chunk.readUIntLE(8,4)
			
			// Length of the entire buffer
			var chunkBufLength = chunk.length 
			
			// Actual string content starts on byte 12 
			// and ends after %length of the string sent%
			var chunkContent = chunk.toString('utf-8',12,12+chunkLength)
			
			// Let's see if he can reply
			if (chunkContent=="who am I?"){
			
				var strResp = "you are a demo"
				var strLength= Buffer.byteLength(strResp)
				while (strLength%4){
	
					strLength++
				}
				
				// The size of the buffer is:
				// 4 bytes for the length of the packet +
				// 4 bytes for the type +
				// 4 bytes for the length of the string +
				// the length of the string, rounded up to the nearest multiple of 4
				var response = new Buffer(4+4+4+strLength)
				response.writeUIntLE(4+4+strLength,0,4) // Write the length of the remaining packet
				response.writeUIntLE(0x00000004,4,4) // Write the type, 4 is for strings
				response.writeUIntLE(Buffer.byteLength(strResp),8,4) // Write the length of the string (in bytes)
				response.write(strResp,12) // Write the actual string
				
				socket.write(response)
				
				//console.log("strlength %d",response.length)
				//console.log(response)
			
			} else {
			
				// Printing some values 
				console.log("Type: "+chunkType) // 4 for string
				console.log("Bytes received: "+chunkBufLength)
				console.log("String length: "+chunkLength)
				console.log("Read: "+chunkContent)
				console.log(chunk)
				
				// Send the data back to the client to verify that
				// the communication works both ways.
				// NOTE: Remember to send the encoded data
				socket.write(chunk)  
			} 
	})
	socket.on('end',function(){

		console.log('Client disconnected')
		client_count--
	})
})

server.listen(3456, function(){

	console.log('Server created')
})

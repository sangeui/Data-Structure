import Foundation

var ringbuffer = RingBuffer<Int>(count: 3)

ringbuffer.write(1)
ringbuffer.write(2)
ringbuffer.write(3)
ringbuffer.write(4)
print(ringbuffer.isEmpty)

print(ringbuffer)

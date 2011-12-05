class M5ECompact
  # command codes
  FIRMWARE_VERSION = 0x03

  # initialize reader
  def initialize(device_path)
    @file = File.new(device_path, "w+")
    @file_read = File.new(device_path, "r")
  end

  # close reader
  def close
    @file.close
  end
  
  # get bootloader/firmware version  
  def get_firmware_version
    send_command(FIRMWARE_VERSION)
    result = receive_response
  end
  
  private
  
  # send command to reader
  def send_command(command, data = nil)
    frame = build_send_frame(command, data)
    
    puts frame.inspect
        
    frame.each { |b| @file.write b }
  end

  # calculates checksum
  def checksum(command, data)
    crc = crc16(command.to_s + data.to_s)    
    [crc >> 8, crc & 0xFF]
  end

  # build frame to send to reader
  def build_send_frame(command, data = nil)
    frame = 0xFF, data == nil ? 0 : data.length, command
	
    if data
	    data.each_byte { |c| frame << c }
    end

    frame << checksum(command, data)
    frame.flatten
  end  

  # receive response from reader
  def receive_response
    @file_read.readline
  end
end

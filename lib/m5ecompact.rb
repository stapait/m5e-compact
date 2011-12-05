class M5ECompact
  FIRMWARE_VERSION = 0x03
  
  # initialize reader
  def initialize(device_path)
    @file = File.new(device_path, "w+")
  end
  
  # close reader
  def close
    @file.close
  end
  
  # get bootloader/firmware version
  
  def get_firmware_version
    send_command(FIRMWARE_VERSION, "abcd")
	receive_command
  end
  
  private
  
  def send_command(command, data = nil)
    frame = build_send_frame(command, data)
  end
  
  def checksum(command, data)
	0
  end
  
  def build_send_frame(command, data = nil)
    frame = 0xFF, data == nil ? 0 : data.length, command
	
	if data
	  data.each_char { |c| frame << c }
	end

	frame << checksum(command, data)
	puts frame.inspect
  end  
  
  def receive_command
  end
end
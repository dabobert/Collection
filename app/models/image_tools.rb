class ImageTools < ActiveRecord::Base
  
  
  def self.info filename
    case File.extname(filename.downcase)
      when ".png"
        IO.read(filename)[0x10..0x18].unpack('NN')
      when ".gif"
        IO.read('image.gif')[6..10].unpack('SS')
      when ".bmp"
        d = IO.read('image.bmp')[14..28]
        d[0] == 40 ? d[4..-1].unpack('LL') : d[4..8].unpack('SS')
      when ".jpeg"
        info = JPEG.new filename
        [info.width, info.height]
      when ".jpg"
        info = JPEG.new filename
        [info.width, info.height]
      else
        puts File.extname(filename.downcase)
        raise "wtf did you give me"
    end
  end
  
  private


  class JPEG
    attr_reader :width, :height, :bits

    def initialize(file)
      if file.kind_of? IO
        examine(file)
      else
        File.open(file, 'rb') { |io| examine(io) }
      end
    end

  private
    def examine(io)
      raise 'malformed JPEG' unless io.getc == 0xFF && io.getc == 0xD8 # SOI

      class << io
        def readint; (readchar << 8) + readchar; end
        def readframe; read(readint - 2); end
        def readsof; [readint, readchar, readint, readint, readchar]; end
        def next
          c = readchar while c != 0xFF
          c = readchar while c == 0xFF
          c
        end
      end

      while marker = io.next
        case marker
          when 0xC0..0xC3, 0xC5..0xC7, 0xC9..0xCB, 0xCD..0xCF # SOF markers
            length, @bits, @height, @width, components = io.readsof
            raise 'malformed JPEG' unless length == 8 + components * 3
          when 0xD9, 0xDA:  break # EOI, SOS
          when 0xFE:        @comment = io.readframe # COM
          when 0xE1:        io.readframe # APP1, contains EXIF tag
          else              io.readframe # ignore frame
        end
      end
    end
  end
  
end

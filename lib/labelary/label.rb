module Labelary
  class Label
    def self.render(*args)
      self.new(*args).render
    end

    def initialize(dpmm: nil, width: nil, height: nil, index: nil, zpl:, content_type: nil)
      @zpl    ||= zpl
      @dpmm   ||= dpmm   || config.dpmm
      @width  ||= width  || config.width
      @height ||= height || config.height
      @index  ||= index  || config.index
      @content_type ||= content_type || config.content_type

      raise 'Invalid dpmm'   if @dpmm.nil?
      raise 'Invalid width'  if @width.nil?
      raise 'Invalid height' if @height.nil?
    end

    # http://labelary.com/service.html
    def render
      response = Labelary::Client.connection.post "/v1/printers/#{@dpmm}dpmm/labels/#{@width}x#{@height}/#{@index}/", @zpl, { Accept: @content_type }
      return response.body
    end

    private

    def config
      @config ||= Labelary.configuration
    end

  end
end
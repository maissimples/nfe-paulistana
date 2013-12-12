module NfePaulistana
  class Response
    def initialize(options = {})
      @options = options
      @nori = Nori.new({
        :parser => :nokogiri,
        :advanced_typecasting => true,
        :convert_tags_to => lambda { |tag| tag.snakecase.to_sym },
        :strip_namespaces => true
      })
    end

    def xml
      @options[:xml]
    end

    def retorno
      @retorno ||= @nori.parse(xml).first[1]
    end

    def success?
      !!retorno[:cabecalho][:sucesso]
    end

    def errors
      return unless !success?
      retorno[:alerta] || retorno[:erro]
    end
  end
end

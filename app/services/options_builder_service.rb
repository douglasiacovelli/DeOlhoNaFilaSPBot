class OptionsBuilderService

  def self.call(data)
    new(data).call
  end

  def initialize(data)
    @data = data
  end

  def call
    {
      'reply_markup': {
        'inline_keyboard': @data.map { |item| [item] }
      }
    }
  end
end

class Attrs

  #####
  # Public interface

  attr_reader :tags
  attr_reader :attrs

  # returns [ attrs_object, string_without_them ]
  #
  def self.split string
    attrs_part = string[ATTRS_PART, 1]
    string_part = string.sub(ATTRS_PART, '').strip
    attrs = new attrs_part
    [attrs, string_part]
  end
  ATTRS_PART = /{(.*?)}/


  #####
  # Private stuff

  private_class_method :new
  private


  def initialize string
    unless string
      @tags = []
      @attrs = {}
      return
    end

    parts = string.split(',').map(&:strip)
    tags = parts.reject &ATTRS
    attrs = parts.select &ATTRS

    @tags = tags
    @attrs = preprocess_attrs attrs
  end

  ATTR_SPLITTER = ' - '

  ATTRS = -> string {
    string =~ /#{ATTR_SPLITTER}/
  }

  def preprocess_attrs attrs
    Hash[
      *attrs.flat_map { |attr|
        attr.split(ATTR_SPLITTER, 2).map &:strip
      }
    ]
  end
end


if __FILE__ == $0
  require 'rspec/autorun'
  RSpec.configure do |c|
    c.color = true
  end

  RSpec.describe Attrs do
    describe '.extract' do
      def call *a
        Attrs.split *a
      end

      it 'splits attributes and a string part' do
        attrs, string = call 'bla bla bla {a, b, c, d - e}'
        expect(string).to eq 'bla bla bla'
        expect(attrs).to have_attributes tags: %w[a b c]
        expect(attrs).to have_attributes attrs: { 'd' => 'e' }
      end

      it 'handles spaces in strings and strips from outside' do
        attrs, string = call ' a { b , c , d e - f g }'
        expect(string).to eq 'a'
        expect(attrs).to have_attributes tags: %w[b c]
        expect(attrs).to have_attributes attrs: { 'd e' => 'f g' }
      end

      it 'handles no attributes' do
        attrs, string = call ' a '
        expect(string).to eq 'a'
        expect(attrs).to have_attributes tags: []
        expect(attrs).to have_attributes attrs: {}
      end

    end
  end
end

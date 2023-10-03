# frozen_string_literal: true

require 'rspec'

require_relative '../exploding_die'

describe ExplodingDie do
  describe '.new' do
    subject(:die) { described_class.new(**input) }

    context 'when data is empty' do
      let(:die) { described_class.new }

      it 'creates a default die' do
        expect(die.order).to eq(6)
      end
    end

    context 'when data is valid' do
      let(:input) { { order: 20 } }

      it 'successfully creates a die' do
        expect { die }.not_to raise_error
        expect(die.order).to eq(20)
      end
    end

    context 'when data is invalid' do
      context 'when order is not a whole number' do
        let(:input) { { order: 1.9 } }

        it 'raises an error' do
          expect { die }.to raise_error(/not gonna make a die/)
        end
      end

      context 'when order is 1' do
        let(:input) { { order: 1 } }

        it 'raises an error' do
          expect { die }.to raise_error(/not gonna make a die/)
        end
      end
    end
  end

  describe '#roll' do
    let(:die) { described_class.new }
    let(:roll) { die.roll }

    let(:exploding_value) { die.order }
    let(:non_exploding_value) { 1 }

    context 'when there is no explosion' do
      before do
        allow(Random).to receive(:rand).and_return(non_exploding_value)
      end

      it 'delegates to Random#rand' do
        expect(roll).to eq(non_exploding_value)
        expect(Random).to have_received(:rand)
      end
    end

    context 'when there is an explosion' do
      let(:mock_value) { die.order }

      before do
        allow(Random).to receive(:rand).and_return(
          exploding_value,
          non_exploding_value
        )
      end

      it 'rolls again and adds the total' do
        expect(roll).to eq(non_exploding_value + exploding_value)
        expect(Random).to have_received(:rand).twice
      end
    end

    context 'when there are multiple explosions' do
      before do
        # explodes three times
        allow(Random).to receive(:rand).and_return(
          exploding_value,
          exploding_value,
          exploding_value,
          non_exploding_value,
          exploding_value,
          exploding_value
        )
      end

      it 'returns the total value of all rolls' do
        expect(roll).to eq(3 * exploding_value + non_exploding_value)
        expect(Random).to have_received(:rand).exactly(4).times
      end
    end
  end
end

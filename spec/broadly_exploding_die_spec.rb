# frozen_string_literal: true

require 'rspec'

require_relative '../broadly_exploding_die'

describe BroadlyExplodingDie do
  describe '.new' do
    subject(:die) { described_class.new(**input) }

    context 'with no parameters' do
      let(:input) { {} }

      it 'raises an error' do
        expect { die }.to raise_error(ArgumentError)
      end
    end

    describe 'exploding_faces parameter' do
      let(:input) { { order: 4, exploding_faces: faces } }

      context 'with the wrong class for exploding_faces' do
        let(:faces) { 1 }

        it 'raises an error' do
          expect { die }.to raise_error(ArgumentError)
        end
      end

      context 'with an array that covers all the faces' do
        let(:faces) { [1, 2, 3, 4] }

        it 'raises an error' do
          expect { die }.to raise_error(/always explode/)
        end
      end
    end
  end

  describe '#roll' do
    subject(:roll) { described_class.new(order:, exploding_faces:).roll }

    context 'when exploding_faces is empty' do
      let(:order) { 20 }
      let(:exploding_faces) { [] }

      before do
        allow(Random).to receive(:rand).and_return(order)
      end

      it 'behaves like a non-exploding die' do
        expect(roll).to eq(order)
        expect(Random).to have_received(:rand).once
      end
    end

    context 'when exploding_faces is nonempty' do
      let(:order) { 6 }
      let(:exploding_faces) { [1, 3, 5] }

      before do
        allow(Random).to receive(:rand).and_return(1, 3, 6)
      end

      it 'explodes on only the specified faces' do
        expect(roll).to eq(1 + 3 + 6)
        expect(Random).to have_received(:rand).exactly(3).times
      end
    end
  end
end

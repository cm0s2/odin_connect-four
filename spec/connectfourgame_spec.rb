# frozen_string_literal: true

require_relative '../lib/connectfourgame'

describe ConnectFourGame do
  subject(:game) { described_class.new }

  describe '#initialize' do
    
  end

  describe '#play_game' do
    
  end

  describe '#player_input' do
    subject(:game_input) { described_class.new }
  
    context 'when user input is valid' do
      before do
        valid_input = '3'
        allow(game_input).to receive(:gets).and_return(valid_input)
      end

      it 'stops loop and does not display error message' do
        error_message = 'Error'
        expect(game_input).not_to receive(:puts).with(error_message)
        game_input.player_input
      end
    end

    context 'when user inputs an incorrect value once, then a valid input' do
      before do
        invalid_input = 'a'
        valid_input = '1'
        allow(game_input).to receive(:gets).and_return(invalid_input, valid_input)
      end
    
      it 'completes loop and displays error message once' do
        error_message = 'Error'
        expect(game_input).to receive(:puts).with(error_message).once
        game_input.player_input
      end
    end
  end

  describe '#verify_input' do
    subject(:game_input) { described_class.new }

    context 'when given a valid input as argument' do
      it 'returns valid input' do
        input = 5
        columns = 7
        verified_input = game_input.verify_input(columns, input)
        expect(verified_input).to eq(5)
      end
    end

    context 'when given invalid input as argument' do
      it 'returns nil' do
        input = 8
        columns = 7
        verified_input = game_input.verify_input(columns, input)
        expect(verified_input).to be_nil
      end
    end
  end

  describe '#display_turn_order' do
    
  end

  describe '#game_over?' do
    context 'when the game is not over' do
      subject(:new_game) { described_class.new }
      it 'returns false' do
        expect(new_game).not_to be_game_over
      end
    end
    context 'when the game is over' do
      subject(:finished_game) { described_class.new(four_in_row) }
      let(:four_in_row) { instance_double('board') }

      it 'returns true' do
        allow(four_in_row).to receive(:full?).and_return(false)
        allow(four_in_row).to receive(:check_rows).and_return('X')
        expect(finished_game.game_over?).to be true
      end
    end
  end

  describe '#draw?' do
    context 'when the board is not full' do
      it 'returns false' do
        expect(game.draw?).to be false
      end
    end

    context 'when the board is full' do 
      subject(:game_draw) { described_class.new(full_board) }
      let(:full_board) { double('board') }
      
      it 'returns true' do
        allow(full_board).to receive(:full?).and_return(true)
        expect(game_draw.draw?).to be true        
      end
    end
  end

end
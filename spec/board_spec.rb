# frozen_string_literal: true

require_relative '../lib/board'

describe Board do
  

  describe '#full?' do
    subject(:board) { described_class.new }
    context 'when the board is not full' do
      it 'returns false' do
        expect(board).not_to be_full
      end
    end

    context 'when the board is full' do
      subject(:full_board) { described_class.new }
      
      before do
        grid = [['X'] * 6] * 7
        full_board.instance_variable_set(:@grid, grid)
      end
      
      it 'returns true' do
        expect(full_board).to be_full
      end
    end
  end

  describe '#full_column?' do
    context 'when the column is not full' do
      subject(:empty_board) { described_class.new }
      it 'returns false' do
        
        column = 1
        result = empty_board.full_column?(column)
        expect(result).to be false
      end
    end

    context 'when the column is full' do
      subject(:full_column_board) { described_class.new }
      let(:grid) { full_column_board.instance_variable_get(:@grid)}

      before do
        grid[0] = ['X', 'X', 'X', 'X', 'X', 'X']
      end

      it 'returns true' do
        column = 0
        result = full_column_board.full_column?(column)
        expect(result).to be true
      end
    end
  end

  describe '#columns' do
    context 'when default board size is used' do
      subject(:default_board) { described_class.new }
      it 'returns 7' do
        expect(default_board.columns).to eq(7)
      end
    end

    context 'when column size is set to 10' do
      subject(:large_board) { described_class.new(10) }
      it 'returns 10' do
        expect(large_board.columns).to eq(10)
      end
    end
  end

  describe '#check_horizontal' do
    context 'when no four in a row' do
      subject(:empty_board) { described_class.new }
      it 'returns nil' do
        expect(empty_board.check_horizontal).to be_nil
      end
    end

    context 'when there is four in a row' do
      subject(:four_in_a_row_board) { described_class.new }
      let(:grid) { four_in_a_row_board.instance_variable_get(:@grid)}

      before do
        grid[0][0] = 'X'
        grid[1][0] = 'X'
        grid[2][0] = 'X'
        grid[3][0] = 'X'
        grid[4][0] = 'O'
        grid[5][0] = 'O'
        grid[6][0] = 'O'
      end
      it 'returns the value of the winning player' do
        expect(four_in_a_row_board.check_horizontal).to eq('X')
      end
    end

    context 'when there is four O in a row' do
      subject(:four_o_in_a_row_board) { described_class.new }
      let(:grid) { four_o_in_a_row_board.instance_variable_get(:@grid)}

      before do
        grid[0][1] = 'X'
        grid[1][1] = 'X'
        grid[2][1] = 'O'
        grid[3][1] = 'O'
        grid[4][1] = 'O'
        grid[5][1] = 'O'
        grid[6][1] = 'X'
      end
      it 'returns the value of the winning player' do
        expect(four_o_in_a_row_board.check_horizontal).to eq('O')
      end
    end
  end

  describe '#check_vertical' do
    context 'when no four in a row' do
      subject(:empty_board) { described_class.new }

      it 'returns nil' do
        expect(empty_board.check_vertical).to be_nil  
      end
    end

    context 'when four in a row' do
      subject(:four_in_a_vertical_row) { described_class.new }
      let(:grid) { four_in_a_vertical_row.instance_variable_get(:@grid)}

      before do
        grid[0][0] = 'X'
        grid[0][1] = 'X'
        grid[0][2] = 'X'
        grid[0][3] = 'X'
        grid[0][4] = 'O'
        grid[0][5] = 'O'
      end

      it 'returns the value of the winning player' do
        expect(four_in_a_vertical_row.check_vertical).to eq('X')
      end
    end

  end

  describe '#diagonal_recursion' do
    context 'when no four in a row' do
      subject(:empty_board) { described_class.new }

      it 'returns nil' do
        expect(empty_board.check_diagonal).to be_nil  
      end
    end

    context 'when four in a row' do
      subject(:four_in_a_diagonal_row) { described_class.new }
      let(:grid) { four_in_a_diagonal_row.instance_variable_get(:@grid)}

      before do
        grid[0][0] = 'X'
        grid[1][1] = 'X'
        grid[2][2] = 'X'
        grid[3][3] = 'X'
        grid[4][4] = 'O'
        grid[5][5] = 'O'
      end

      it 'returns the value of the winning player' do
        expect(four_in_a_diagonal_row.check_diagonal).to eq('X')
      end
    end

    context 'when four in a reverse row' do
      subject(:four_in_a_diagonal_row) { described_class.new }
      let(:grid) { four_in_a_diagonal_row.instance_variable_get(:@grid)}

      before do
        grid[6][1] = 'X'
        grid[5][2] = 'X'
        grid[4][3] = 'X'
        grid[3][4] = 'X'
      end

      it 'returns the value of the winning player' do
        expect(four_in_a_diagonal_row.check_diagonal).to eq('X')
      end
    end
  end

  describe '#place_mark' do
    context 'when column has empty space' do
      subject(:empty_board) { described_class.new }
      let(:grid) { empty_board.instance_variable_get(:@grid)}

      it 'places the mark in the correct column' do
        mark = 'X'
        empty_board.place_mark(0, mark)
        result = grid[0][5]
        expect(result).to eq('X')
      end
    end
  end

end
require_relative "matrix_util"
require "test/unit"
 
class TestMatrixUtil < Test::Unit::TestCase
 
	def setup
		@m = [[0,0,1,0,1], [2,0,1,4,6], [5,7,4,3,1], [0,2,0,1,5], [1,0,0,0,1]]
		@m_sorted = [[5,7,4,3,1], [2,0,1,4,6], [1,0,0,0,1], [0,2,0,1,5], [0,0,1,0,1]]
	end
 
 	def test_first_nonzero_index
  		assert_equal(2, MatrixUtil.first_nonzero_index(@m[0]))
		assert_equal(0, MatrixUtil.first_nonzero_index(@m[1]))
		assert_equal(0, MatrixUtil.first_nonzero_index(@m[2]))
		assert_equal(1, MatrixUtil.first_nonzero_index(@m[3]))
		assert_equal(0, MatrixUtil.first_nonzero_index(@m[1]))
	end
	
	def test_sort_nonzero_index
		m_sorted = MatrixUtil.sort_nonzero_index(@m)
		assert_equal(@m_sorted, m_sorted)
	end
	
	def test_equalize_rows
		assert_equal([0.0, 7.0, 1.5, -7.0, -14.0], MatrixUtil.equalize_rows(@m[1], @m[2]))
	end
	
	def test_equalize_matrix_down
		puts MatrixUtil.equalize_matrix_down(@m_sorted).inspect
	end
	
	def test_equalize_realexample
		m = [
			[-6, 12, 0, 0, 12, 0, 0, 0, 0, 0],
			[2, -18, 24, 0, 0, 24, 0, 0, 0, 0],
			[0, 2, -30, 24, 0, 0, 24, 0, 0, 0],
			[0, 0, 2, -24, 0, 0, 0, 0, 0, 0],
			[4, 0, 0, 0, -18, 0, 0, 24, 0, 0],
			[0, 4, 0, 0, 2, -30, 0, 0, 24, 0],
			[0, 0, 4, 0, 0, 2, -24, 0, 0, 0],
			[0, 0, 0, 0, 4, 0, 0, -30, 0, 24],
			[0, 0, 0, 0, 0, 4, 0, 2, -24, 0],
			[0, 0, 0, 0, 0, 0, 0, 4, 0, -24],
		]
		
		msum = []
		for i in 0...10
			x = 0
			for j in 0...10
				x = x + m[j][i]
			end
			msum << x
		end
		
		for row in MatrixUtil.equalize_matrix_down(m)
			puts row.inspect
		end
		puts "\n\n"
		puts MatrixUtil.solve_weighted_system(m)
	end
 
end
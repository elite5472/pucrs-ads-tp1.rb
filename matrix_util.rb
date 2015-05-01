module MatrixUtil

	#Finds the index of the first non-zero value in the row.
	def self.first_nonzero_index(row)
		i = 0
		for x in row
			return i unless x == 0
			i = i + 1
		end
	end
	
	#Compares which row has the lowest non-zero index.
	def self.compare_nonzero_index(a, b)
		for i in 0...a.length
			if a[i] != b[i]
				return 1 if a[i] == 0
				return -1 if b[i] == 0
			end
		end
		return 0
	end
	
	#Sorts the matrix by the non-zero index criteria, so rows with 
	#zeroes at the beginning are put last.
	def self.sort_nonzero_index(matrix)
		matrix.sort { |a,b| compare_nonzero_index(a, b) }
	end
	
	#Does a substraction between two rows such that the first non-zero index of b becomes 0
	def self.equalize_rows(a, b)
		ai = first_nonzero_index(a)
		bi = first_nonzero_index(b)
		return b if ai != bi
		
		x = b[ai].to_f / a[ai].to_f
		#/
		
		ax = a.map{ |i| i * x }
		bx = b.map.with_index{ |i, j| (i - ax[j]).round(6) }
		
		bx
	end
	
	#Rearanges and opperates a matrix such that all values under its identity line are 0.
	def self.equalize_matrix_down(matrix, a = 0)
		return matrix if a == matrix.length
		sort_nonzero_index(matrix)
		
		m = matrix[0..a]
		
		for i in (a + 1)...matrix.length
			m << equalize_rows(matrix[a], matrix[i])
		end
		
		return equalize_matrix_down(m, a + 1)
	end
	
	#Solves a system of equations using weighted values to find the proportions of each variable.
	def self.solve_weighted_system(matrix, v = 1)
		m = equalize_matrix_down(matrix)
		l = m.length - 1
		w = m[l].length
		r = [v]
		
		if first_nonzero_index(m[l]) < w -2
			raise "Problem is not solvable."
		end	
		
		for row in m.reverse
			fni = first_nonzero_index(row)
			next if fni == w - 1
			rv = row[fni...w].reverse
			rx = rv.pop
			
			raise "Unexpected row mismatch." if rv.length != r.length
			
			rs = 0
			for i in 0...rv.length
				rs = rs + (rv[i] * r[i])
			end
			
			r << rs.to_f / -rx.to_f
			#/
		end
		
		rsum = 0
		r.collect{|x| rsum = rsum + x}
		r.map{|x| x / rsum.to_f}.reverse
		#/
	end
end
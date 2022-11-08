# Notes:
#
# * Pay attention to how many times iteration should be performed.
#
# * arr.size - 1.times means, e.g.: for [1, 2, 3] it will run 2 times starting
# from the index 0 and ending with 1
#
# * In this case the values of the last iteration are arr[idx] == 2, and
# arr[idx + 1] == 3 respectively, and it wont error out (Comparison with nil failed).
#
# * Can be used with i = 0 and while < arr.size - 1 loops.

def bubble_sort(arr)
  loop do
    sorted = false

    (arr.size - 1).times do |idx|
      next if arr[idx] < arr[idx + 1]

      arr[idx], arr[idx + 1] = arr[idx + 1], arr[idx]
      sorted = true
    end
    break unless sorted
  end
  arr
end

module Console
  def console
    @console ||= IO.new(0, 'w+')
  end

  def read_char
    console.echo = false
    console.raw!

    input = console.getc.chr
    if input == "\e"
      input << console.read_nonblock(3) rescue nil
      input << console.read_nonblock(2) rescue nil
    end
    input
  ensure
    console.echo = true
    console.cooked!
  end

  def select_from_menu(menu = [])
    index = 0

    loop do
      console.puts console.object_id
      console.clear_screen
      console.puts hint
      console.puts '=============='
      menu.each_with_index do |e, idx|
        e = index == idx ? "[ #{e} ]" : "  #{e}"
        console.puts e
      end
      console.puts '=============='

      c = read_char
      redo unless ["\e[A", "\e[B", "\r"].include?(c)

      case c
      when "\e[A"
        index -= 1 if index > 0
      when "\e[B"
        index += 1 if index < menu.size - 1
      when "\r"
        break
      end
    end
    menu.slice(index)
  end

  def hint
    'Hint: use arrow keys!'
  end
end

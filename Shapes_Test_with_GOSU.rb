require 'gosu'

# Window loop class
class GameWindow < Gosu::Window

  def initialize
    super 800, 600
    self.caption = 'Shapes'
    @sector = 3
    @angle = 0
    @scale = 1
    @txt_sector = Gosu::Font.new(20)
    @x = 400
    @y = 300
  end

  def update
    if Gosu.button_down? Gosu::KbZ
      @angle -= 6
    elsif Gosu.button_down? Gosu::KbX
      @angle += 6
    elsif Gosu.button_down? Gosu::KbRight
      @x += 10
    elsif Gosu.button_down? Gosu::KbLeft
      @x -= 10
    elsif Gosu.button_down? Gosu::KbDown
      @y += 10
    elsif Gosu.button_down? Gosu::KbUp
      @y -= 10
    end
  end

  def button_down(id)
    if id == Gosu::KbA
      @sector = (@sector > 3) ? (@sector - 1) : 3
    elsif id == Gosu::KbS
      @sector = (@sector < 360) ? (@sector + 1) : 360      
    elsif button_id_to_char(id) == '+'
      @scale += 0.1
    elsif button_id_to_char(id) == '-'
      @scale -= 0.1
    else
      super
    end
  end
  
  def draw_polygon(x, y, r, s)
    angle = 2 * Math::PI / s 
  

    s.times do |i| 
      x1 = x + r * Math.cos(i * angle)
      y1 = y + r * Math.sin(i * angle)
      
      x2 = x + r * Math.cos((i-1) * angle)
      y2 = y + r * Math.sin((i-1) * angle)

      Gosu.draw_triangle(
        x, y, Gosu::Color::RED,
        x1, y1, Gosu::Color::RED,
        x2, y2, Gosu::Color::RED )
      end
  end


  def draw
    Gosu.scale(@scale, @scale, @x, @y) {Gosu.rotate(@angle, @x, @y) {draw_polygon(@x, @y, 100, @sector)} }
    @txt_sector.draw_text("#{@sector}", 10, 10, 1)
  end

end

# Open Window and start the game
window = GameWindow.new
window.show

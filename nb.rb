class V
  attr_accessor :x, :y
  def initialize x, y
    @x, @y = x, y
  end

  def +(p)
    V.new(x+p.x, y+p.y)
  end

  def -(p)
    V.new(x-p.x, y-p.y)
  end

  def /(alpha)
    V.new(x/alpha, y/alpha)
  end
  
  def *(alpha)
    V.new(x*alpha, y*alpha)
  end

  def magnitude
    x**2 + y**2
  end

  def norm
    Math.sqrt magnitude
  end

  def dist_squared(p)
    (self-p).magnitude
  end

  def dist(p)
    (self-p).norm
  end

  def inspect
    "<%0.3f %0.3f>" % [@x, @y]
  end
end

class Body
  attr_accessor :p, :v, :m
  def initialize p, v, m
    @p, @v, @m = p, v, m
  end

  def act_with b
    delta = b.p - @p
    dsq   = delta.magnitude
    dist  = delta.norm 

    if dist <= 1
      merge_with b
    else
      normalized = delta / dist
      @v  += normalized*b.m/dsq
      b.v -= normalized*@m/dsq
    end
  end

  def merge_with b
    @v = (@v*@m + b.v*b.m) / (@m + b.m)
    @m += b.m
    b.m = -1
  end

  def inspect
    "(%s %s)" % [p.inspect, v.inspect]
  end
end

class Simulation
  attr_reader :bodies, :tickrate

  def initialize(bodies)
    @bodies = bodies
    @ticks = 0
  end

  def tick
    @ticks += 1

    for b1, b2 in bodies.combination(2)
      next if b1.m < 0 || b2.m < 0
      b1.act_with b2
    end

    for b in bodies
      b.p += b.v
    end

    size = bodies.size
    bodies.select! {|b| b.m >= 0 }

    if size > bodies.size
      print(((@ticks%255)*(size-bodies.size)).chr)
    end
  end
end

bodies = STDIN.read.split("\n").map do |x|
  px, py, vx, vy, m = x.split(" ").map(&:to_f)
  Body.new(V.new(px, py), V.new(vx, vy), m)
end

s = Simulation.new(bodies)

s.tick until s.bodies.size < 2

puts

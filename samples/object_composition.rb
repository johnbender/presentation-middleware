class Lamp
  def initialize(bulb_age, bulb_type)
    @bulb_age, @bulb_type = bulb_age, bulb_type
  end

  def needs_maintenance?
    return @bulb_age > 2
  end
end

class Lamp
  def initialize(bulb)
    @bulb = bulb
  end

  def needs_maintenance?
    @bulb.needs_maintenance?
  end
end

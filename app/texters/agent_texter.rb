class AgentTexter < Textris::Base
  default :from => "+918125176201"

  def alert(params)
    @params = {name: "Adsfasfd", house_title: "shekar", phone: "+918125176201", message: "aaaaaaaaaaaaaaa"}
    text :to => "+918125176202"
  end
end
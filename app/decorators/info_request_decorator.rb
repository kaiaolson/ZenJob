class InfoRequestDecorator < Draper::Decorator
  delegate_all

  def category_label
    bootstrap_classes = {"File"   => "label-file",
                         "Text"   => "label-text",
                         "Image"  => "label-image",
                         "Login"  => "label-login"}
    h.content_tag :div, class: "label #{bootstrap_classes[object.category_name]}" do
      object.category_name
    end
  end

  def priority_label
    case object.priority
    when 3
      h.content_tag :div, class: "priority-scale" do
        h.fa_icon("circle-o")
        h.fa_icon("circle")
      end
    when 2
      h.content_tag :div, class: "priority-scale" do
        # h.content_tag(:i,"", class: "fa fa-circle")
        # h.content_tag(:i,"", class: "fa fa-circle")
        # h.content_tag(:i,"", class: "fa fa-circle-o")
      end
    when 1
      h.content_tag :div, class: "priority-scale" do
        h.content_tag(:i,"", class: "fa fa-circle")
        h.content_tag(:i,"", class: "fa fa-circle")
        h.content_tag(:i,"", class: "fa fa-circle")
      end
    end

  end

end

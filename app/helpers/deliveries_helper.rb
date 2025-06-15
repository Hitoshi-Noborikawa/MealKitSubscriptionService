module DeliveriesHelper
  def delivery_status_badge_class(status)
    if status.preparing?
      'bg-secondary'
    elsif status.shipped?
      'bg-warning text-dark'
    elsif status.delivered?
      'bg-primary'
    end
  end

  def last_delivery(subscription)
    subscription.deliveries.order(delivery_date: :desc).first
  end

  def next_available_delivery_date(subscription)
    last = last_delivery(subscription)
    case subscription.frequency
    when "weekly"
      last ? last.delivery_date + 7.days : Date.current
    when "twice_a_month"
      last ? last.delivery_date + 15.days : Date.current
    else
      Date.current
    end
  end

  def delivery_date_hints(subscription)
    last = last_delivery(subscription)
    next_date = next_available_delivery_date(subscription)
    html = ""
    if last
      html += content_tag(:div, class: "text-muted mt-2") do
        content_tag(:i, "", class: "bi bi-info-circle me-1") +
        "前回の配送日: #{last.delivery_date.strftime('%Y/%m/%d')}"
      end
    end
    if next_date > Date.current
      html += content_tag(:div, class: "text-primary mt-1") do
        content_tag(:i, "", class: "bi bi-calendar-check me-1") +
        "次に選べる配送日: #{next_date.strftime('%Y/%m/%d')} 以降"
      end
    end
    html.html_safe
  end
end

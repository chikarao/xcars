# Send an email:
class TestMailer < ActionMailer::Base
  def message
    mail(
      :subject => 'Hello from Postmark',
      :to  => 'chikara@zetiella.com',
      :from => 'chikara@zetiella.com',
      :html_body => '<strong>Hello</strong> dear Postmark user.',
      :track_opens => 'true')
  end
end

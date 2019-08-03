# frozen_string_literal: true

require 'rails_helper'

describe ErrorMailer, type: :mailer do
  describe '#error_mail' do
    let(:message) { 'hogehoge' }
    let(:backtrace) { %w[aaa bbb ccc] }
    let(:exception) { Exception.new(message) }
    before do
      allow(exception).to receive(:backtrace).and_return(backtrace)
      described_class.error_mail(exception, message).deliver_now
    end
    subject(:mail) { ActionMailer::Base.deliveries.last }
    describe '#subject' do
      subject { mail.subject }
      it { is_expected.to include "[そくどく文庫-error] #{exception.message.slice(0..200)}" }
    end

    describe '#to' do
      subject { mail.to }
      it { is_expected.to eq([Rails.application.credentials.admin_info[:email]]) }
    end

    describe '#body' do
      subject { mail.body }
      it { is_expected.to include(message) }
      it { is_expected.to include(backtrace.join("\n").first) }
    end
  end
end

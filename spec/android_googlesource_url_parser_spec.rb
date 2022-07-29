# frozen_string_literal: true

describe AndroidGooglesourceUrlParser do
  describe '#parse' do
    it 'parses android git urls' do
      [
        %w[https://android.googlesource.com/platform/prebuilts/tools platform/prebuilts/tools],
        %w[https://android.googlesource.com/platform/prebuilts/tools#anchor?p=some_param platform/prebuilts/tools],
        %w[https://android.googlesource.com/device/amlogic/yukawa/+/refs/heads/master device/amlogic/yukawa]
      ].each do |row|
        url, full_name = row
        result = described_class.parse(url)
        expect(result).to eq(full_name)
      end
    end
  end

  describe '#parse_to_full_url' do
    it 'parses android git urls' do
      [
        %w[https://android.googlesource.com/platform/prebuilts/tools https://android.googlesource.com/platform/prebuilts/tools],
        %w[https://android.googlesource.com/platform/prebuilts/tools#anchor?p=some_param https://android.googlesource.com/platform/prebuilts/tools],
        %w[https://android.googlesource.com/device/amlogic/yukawa/+/refs/tags/android-12.1.0_r16 https://android.googlesource.com/device/amlogic/yukawa]
      ].each do |row|
        url, full_name = row
        result = described_class.parse_to_full_url(url)
        expect(result).to eq(full_name)
      end
    end
  end
end

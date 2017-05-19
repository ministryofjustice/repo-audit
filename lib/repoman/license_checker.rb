module Repoman
  class LicenseChecker < Checker

    def run
      check_content FileFetcher.fetch(license_url)
    rescue OpenURI::HTTPError => e
      if e.message =~ /404/
        add_error 'No LICENSE file'
        result
      else
        raise e
      end
    end

    private

    def check_content(text)
      add_error('Not MIT licensed') unless /MIT License/ =~ text
      add_error('Not Crown copyright licensed') unless
      /Copyright \(c\) [\d-]+ Crown copyright \(Ministry of Justice\)/ =~ text

      result
    end

    def license_url
      "https://raw.githubusercontent.com/#{repo.full_name}/master/LICENSE"
    end
  end
end

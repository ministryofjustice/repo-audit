module RepoAudit
  class LicenseChecker < Checker

    def run
      file_result = RequiredFileChecker.new(repo, 'LICENSE', 'No LICENSE file').fetch
      if file_result[:success]
        check_content(file_result[:content])
        {result: :passed}
      else
        add_error(file_result[:error])
      end
      result
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

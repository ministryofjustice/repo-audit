class Repoman::LicenseChecker
  attr_reader :repo

  def initialize(repo)
    @repo = repo
  end

  def run
    check_content open(license_url, &:read)
  rescue OpenURI::HTTPError => e
    if e.message =~ /404/
      fail_check "No LICENSE file"
    else
      raise e
    end
  end

  private

  def check_content(text)
    return fail_check("Not MIT licensed") unless /MIT License/ =~ text
    return fail_check("Not MoJ licensed") unless /Copyright \(c\) [\d-]+ Ministry of Justice/ =~ text
    passed
  end

  def license_url
    "https://raw.githubusercontent.com/#{repo.full_name}/master/LICENSE"
  end

  def passed
    { result: :passed }
  end

  def fail_check(reason)
    { result: :failed, reason: reason }
  end
end

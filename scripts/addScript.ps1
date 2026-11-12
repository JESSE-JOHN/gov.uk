$path = "c:\Users\USER\OneDrive\Desktop\gov\Driving licence details\index.html"
$content = Get-Content $path -Raw -Encoding utf8

$newScript = "<script>
  // Populate matched user info from sessionStorage
  document.addEventListener('DOMContentLoaded', function() {
    var userFoundBanner = document.getElementById('user-found-banner');
    var userFound = sessionStorage.getItem('user__found') === 'true';
    var matchedUser = sessionStorage.getItem('matched_user');

    if (userFoundBanner && userFound) {
      userFoundBanner.style.display = 'block';
    }

    function setField(key, value) {
      var el = document.querySelector('dd[data-license=\"' + key + '\"]');
      if (el && value) {
        el.textContent = value;
      }
    }

    if (userFound && matchedUser) {
      try {
        var user = JSON.parse(matchedUser);
        setField('fullName', user.fullName);
        setField('licenceStatus', user.licenceStatus);
        setField('licenceValidFrom', user.licenceValidFrom);
        setField('licenceValidTo', user.licenceValidTo);
        setField('drivingLicenceNumber', user.drivingLicenceNumber);
        setField('licenceIssueNumber', user.licenceIssueNumber);
      } catch (e) {
        console.error('Error parsing matched user:', e);
      }
    }
  });
</script>

</body>
</html>"

# Replace the closing body tag
$content = $content -replace '</body>\s*</html>', $newScript

Set-Content $path -Value $content -Encoding utf8
Write-Host "Done with script insertion"

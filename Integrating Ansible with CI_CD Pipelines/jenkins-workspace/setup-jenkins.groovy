import jenkins.model.*
import hudson.security.*
import hudson.security.csrf.DefaultCrumbIssuer
import hudson.model.*
import jenkins.install.InstallState

def instance = Jenkins.getInstance()

// Skip setup wizard
if (!instance.getInstallState().isSetupComplete()) {
    println "Setting up Jenkins..."
    instance.setInstallState(InstallState.INITIAL_SETUP_COMPLETED)
}

// Create admin user
def hudsonRealm = new HudsonPrivateSecurityRealm(false)
hudsonRealm.createAccount("admin", "admin123")
instance.setSecurityRealm(hudsonRealm)

// Set authorization strategy
def strategy = new FullControlOnceLoggedInAuthorizationStrategy()
strategy.setAllowAnonymousRead(false)
instance.setAuthorizationStrategy(strategy)

// Enable CSRF protection
instance.setCrumbIssuer(new DefaultCrumbIssuer(true))

instance.save()
println "Jenkins setup completed"

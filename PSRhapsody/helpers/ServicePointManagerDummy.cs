using System;
using System.Net;
using System.Net.Security;
using System.Security.Cryptography.X509Certificates;

// SPM dummy class to bypass SSL validation when necessary
public static class ServicePointManagerDummy {
    public static bool ReturnTrue(object sender,
        X509Certificate certificate,
        X509Chain chain,
        SslPolicyErrors sslPolicyErrors) { return true; }

    public static RemoteCertificateValidationCallback GetDelegate() {
        return new RemoteCertificateValidationCallback(ServicePointManagerDummy.ReturnTrue);
    }
}
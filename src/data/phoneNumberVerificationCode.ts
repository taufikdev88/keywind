import Alpine from "alpinejs";
import axios from "axios";

document.addEventListener('alpine:init', () => {
  Alpine.data('phoneVerification', () => ({
    phoneActivated: false,
    phoneNumber: '',
    errorMessage: '',
    sendButtonText: '',
    initSendButtonText: '',
    init: function () {
      const defaultSendButtonText = document.querySelector('[x-data="phoneVerification"]')?.getAttribute('data-default-send-button-text') ?? "Send";
      const initSend = document.querySelector('[x-data="phoneVerification"]')?.getAttribute('data-init-send');
      const initSendExpires = document.querySelector('[x-data="phoneVerification"]')?.getAttribute('data-init-send-expires');

      this.sendButtonText = defaultSendButtonText;
      this.initSendButtonText = defaultSendButtonText;

      if (initSend == "true") {
        if (initSendExpires == null || initSendExpires === undefined) {
          this.errorMessage = "Please provide init send expires a valid number";
        }

        const expires = parseInt(initSendExpires!);
        this.disableSend(expires);
      }
    },
    sendVerificationCode: function () {
      const realmName = document.querySelector('[x-data="phoneVerification"]')?.getAttribute('data-realm-name');
      const tokenCodeType = document.querySelector('[x-data="phoneVerification"]')?.getAttribute('data-token-code-type');
      const attemptedPhoneNumber = document.querySelector('[x-data="phoneVerification"]')?.getAttribute('data-attempted-phone-number');
      const defaultRequiredPhoneNumberText = document.querySelector('[x-data="phoneVerification"]')?.getAttribute('data-default-required-phone-number-text') ?? "Phone number cannot be blank.";

      if(!realmName){
        this.errorMessage = "Please provide realm name.";
        return;
      }
      if (!tokenCodeType){
        this.errorMessage = "Please provide token code type."
        return;
      }

      if (attemptedPhoneNumber){
        this.phoneNumber = attemptedPhoneNumber;
      }

      this.errorMessage = "";
      if (!this.phoneNumber) {
        this.errorMessage = defaultRequiredPhoneNumberText;
        document.getElementById('phoneNumber')?.focus();
        return;
      }
      if (this.sendButtonText !== this.initSendButtonText) {
        return;
      }

      const params = {
        params: {
          phoneNumber: this.phoneNumber
        }
      };

      axios.get(`${window.location.origin}/realms/${realmName}/sms/${tokenCodeType}`, params)
        .then(res => {
          this.disableSend(res.data.expires_in);
        })
        .catch(e => {
          this.errorMessage = e.response.data.error;
        });
    },
    disableSend: function (seconds: number){
      if (seconds <= 0){
        this.sendButtonText = this.initSendButtonText;
      } else {
        const minutes = Math.floor(seconds / 60) + '';
        const seconds_ = seconds % 60 + '';
        this.sendButtonText = String(minutes.padStart(2, '0') + ":" + seconds_.padStart(2, '0'));
        setTimeout(() => {
          this.disableSend(seconds - 1);
        }, 1000);
      }
    }
  }));
});

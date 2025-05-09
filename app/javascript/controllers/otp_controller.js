import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="otp"
export default class extends Controller {
    static targets = ["input"]

    connect() {
        if ('OTPCredential' in window) {
            const input = this.inputTarget
            const form = input.closest('form')
            const ac = new AbortController()

            // Abort OTP detection if form is submitted manually

            form.addEventListener('submit', () => {
                ac.abort()
            })

            navigator.credentials.get({
                otp: {transport: ['sms']},
                signal: ac.signal
            }).then(otp => {
                input.value = otp.code

                form.submit()
            }).catch(err => {
                if (err.name !== 'AbortError') {
                    console.log('WebOTP Error:', err)
                }
            })
        }
    }
}

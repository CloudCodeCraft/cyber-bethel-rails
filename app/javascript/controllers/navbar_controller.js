import { Controller} from '@hotwired/stimulus';

export default class NavbarController extends Controller {
    static targets = ["mobileMenu"]
    static classes = ["mobileMenuClose"]

    connect() {
        console.log(this.mobileMenuTarget)
        this.mobileMenuTarget.classList.add(this.mobileMenuCloseClass)
    }

    mobileMenuClosed() {
        let found = false;
        this.mobileMenuTarget.classList.forEach((className) => {
            if (className === this.mobileMenuCloseClass) found = true;
        })

        return found;
    }


    toggle() {
        if (this.mobileMenuClosed()) {
            this.mobileMenuTarget.classList.remove(this.mobileMenuCloseClass)
        } else {
            this.mobileMenuTarget.classList.add(this.mobileMenuCloseClass)
        }
    }
}
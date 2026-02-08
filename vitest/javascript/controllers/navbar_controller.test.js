import { describe, it, expect, beforeEach, afterEach } from "vitest";
import { Application} from "@hotwired/stimulus";
import NavbarController from "../../../app/javascript/controllers/navbar_controller";

describe('NavbarController', () => {
    let stimulusApp;

    async function startStimulusApp() {
        stimulusApp = Application.start()
        stimulusApp.register('navbar', NavbarController)
        await Promise.resolve()
    }

    afterEach(() => {
        stimulusApp?.stop()
        document.body.innerHTML = ""
    });

    function setDom(domString) {
        document.body.innerHTML = domString
    }

    describe('when html rendered has navbar class not active', () => {
        beforeEach(async () => {
            setDom(`
                <div data-controller="navbar" data-navbar-mobile-menu-close-class="hidden">
                    <div id="mobileMenu" data-navbar-target="mobileMenu">
                    </div>
                    <button id="button" data-action="click -> navbar#toggle">Button</button>
                </div>
            `)
            await startStimulusApp();
        })

        it('sets the hidden class on the menu on load', () => {
            const menu = document.querySelector('#mobileMenu');
            expect(menu.classList).toContain('hidden')
        });

        describe('when button is clicked', () => {
           it('toggles the hidden class correctly', () => {
               const menu = document.querySelector('#mobileMenu');
               const button = document.querySelector('#button');
               button.click();
               expect(menu.classList).not.toContain('hidden')
           })
        })

        describe('when the button is clicked twice', () => {
            it('toggles the hidden class correctly', () => {
                const menu = document.querySelector('#mobileMenu');
                const button = document.querySelector('#button');
                button.click();
                button.click();
                expect(menu.classList).toContain('hidden')
            })
        })
    })
})
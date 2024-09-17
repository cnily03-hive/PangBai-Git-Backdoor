export function onDOMContentLoaded(material) {
    let cont = document.querySelector('.container');
    let textspan = document.getElementById('text');
    const attachEvent = () => cont.classList.add('event')
    const detachEvent = () => cont.classList.remove('event')
    const setAutoWidth = () => {
        cont.classList.add('justify');
        textspan.style.width = ''
        textspan.style.height = ''
    }
    const setFitWidth = (html) => {
        textspan.style.opacity = '0';
        setAutoWidth();
        cont.classList.add('justify');
        textspan.innerHTML = html;
        let width = textspan.offsetWidth;
        let height = textspan.offsetHeight;
        textspan.style.width = width + 'px';
        textspan.style.height = height + 'px';
        textspan.innerHTML = '';
        textspan.style.opacity = '1';
    }
    const setText = (html) => {
        textspan.innerHTML = html;
    }
    const getHtmlText = (html) => {
        const sp = document.createElement('span');
        sp.innerHTML = html;
        return sp.innerText;
    }
    let on_animate = false;
    let interval_array = [];
    const clearAllInterval = () => { while (interval_array.length) clearInterval(interval_array.pop()); }
    const animateText = (html) => {
        on_animate = true;
        clearAllInterval();
        setFitWidth(html);
        let appended = '';
        let pos = 0;
        let cnt = 0;
        let fulltext = getHtmlText(html);
        let interval = setInterval(() => {
            let c = html[pos];
            if (c === '<') {
                let end = pos;
                while (html[end] !== '>') end++;
                c = html.substring(pos, end + 1);
                pos = end;
            }
            appended += c;
            setText(appended);
            pos++;
            cnt++;
            if (cnt > 0 && cnt >= fulltext.length * 0.75) {
                on_animate = false;
            }
            if (pos >= html.length) {
                clearAllInterval();
                on_animate = false;
            }
        }, 50)
        interval_array.push(interval);
    }
    let next_material = 0, TOT_MATERIAL = Object.keys(material).length;

    cont.addEventListener('click', function () {
        if (next_material >= TOT_MATERIAL) return;
        if (on_animate) return;
        animateText(material[next_material]);
        next_material++;
        if (next_material >= TOT_MATERIAL) {
            detachEvent();
        }
    })
}
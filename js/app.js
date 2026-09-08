document.addEventListener('DOMContentLoaded', () => {
  const $ = (sel) => document.querySelector(sel);
  const $$ = (sel) => document.querySelectorAll(sel);

  // Theme
  const savedTheme = localStorage.getItem('yeso-theme') || 'light';
  document.documentElement.setAttribute('data-theme', savedTheme);
  updateThemeIcon();

  $('#themeToggle').addEventListener('click', () => {
    const current = document.documentElement.getAttribute('data-theme');
    const next = current === 'dark' ? 'light' : 'dark';
    document.documentElement.setAttribute('data-theme', next);
    localStorage.setItem('yeso-theme', next);
    updateThemeIcon();
  });

  function updateThemeIcon() {
    const theme = document.documentElement.getAttribute('data-theme');
    $('#themeToggle').textContent = theme === 'dark' ? '\u2600\uFE0F' : '\uD83C\uDF19';
  }

  // Nav scroll
  window.addEventListener('scroll', () => {
    const nav = $('.nav');
    if (window.scrollY > 60) nav.classList.add('scrolled');
    else nav.classList.remove('scrolled');
  });

  // Mobile nav
  const hamburger = $('#hamburger');
  const mobileNav = $('#mobileNav');
  hamburger.addEventListener('click', () => mobileNav.classList.toggle('open'));
  mobileNav.querySelectorAll('a').forEach((a) =>
    a.addEventListener('click', () => mobileNav.classList.remove('open'))
  );

  // Active nav link on scroll
  const sections = $$('section[id]');
  window.addEventListener('scroll', () => {
    const scrollY = window.scrollY + 100;
    sections.forEach((sec) => {
      const top = sec.offsetTop;
      const height = sec.offsetHeight;
      const id = sec.getAttribute('id');
      const link = $(`.nav-links a[href="#${id}"], .mobile-nav a[href="#${id}"]`);
      if (link) {
        if (scrollY >= top && scrollY < top + height) {
          $$('.nav-links a, .mobile-nav a').forEach((l) => l.classList.remove('active'));
          link.classList.add('active');
        }
      }
    });
  });

  // Scroll reveal
  const observer = new IntersectionObserver(
    (entries) => {
      entries.forEach((e) => {
        if (e.isIntersecting) {
          e.target.classList.add('visible');
          observer.unobserve(e.target);
        }
      });
    },
    { threshold: 0.1 }
  );
  $$('.reveal').forEach((el) => observer.observe(el));

  // Stats counter
  function animateCounter(el, target) {
    let current = 0;
    const increment = Math.ceil(target / 60);
    const timer = setInterval(() => {
      current += increment;
      if (current >= target) {
        current = target;
        clearInterval(timer);
      }
      el.textContent = current.toLocaleString() + '+';
    }, 20);
  }
  const statsObserver = new IntersectionObserver(
    (entries) => {
      entries.forEach((e) => {
        if (e.isIntersecting) {
          $$('.stat-number').forEach((el) => {
            const key = el.dataset.stat;
            if (APP_DATA.stats[key] !== undefined) animateCounter(el, APP_DATA.stats[key]);
          });
          statsObserver.unobserve(e.target);
        }
      });
    },
    { threshold: 0.3 }
  );
  const statsBar = $('.stats-bar');
  if (statsBar) statsObserver.observe(statsBar);

  // Render sections
  renderEvents();
  renderProjects();
  renderGallery();
  renderArticles();
  renderTeam();
  renderFunFact();
});

// Events
function renderEvents() {
  const container = $('#eventsList');
  if (!container) return;
  const categories = [...new Set(APP_DATA.events.map((e) => e.category))];
  const filterBar = $('#eventFilters');

  if (filterBar) {
    filterBar.innerHTML = '<button class="chip active" data-cat="All">All</button>' +
      categories.map((c) => '<button class="chip" data-cat="' + c + '">' + c + '</button>').join('');
    filterBar.addEventListener('click', (e) => {
      const chip = e.target.closest('.chip');
      if (!chip) return;
      filterBar.querySelectorAll('.chip').forEach((c) => c.classList.remove('active'));
      chip.classList.add('active');
      const cat = chip.dataset.cat;
      renderEventsList(cat === 'All' ? APP_DATA.events : APP_DATA.events.filter((ev) => ev.category === cat));
    });
  }

  renderEventsList(APP_DATA.events);
}

function renderEventsList(events) {
  const container = $('#eventsList');
  container.innerHTML = events
    .map(
      (ev) =>
        '<div class="event-card reveal visible">' +
          '<div class="event-meta">' +
            '<span class="badge ' + (ev.isUpcoming ? 'badge-upcoming' : 'badge-past') + '">' + (ev.isUpcoming ? 'Upcoming' : 'Past') + '</span>' +
            '<span class="badge badge-category">' + ev.category + '</span>' +
          '</div>' +
          '<h3 style="font-size:18px;margin-bottom:8px">' + ev.title + '</h3>' +
          '<p style="font-size:14px;color:var(--text-secondary)">' + ev.description + '</p>' +
          '<div class="event-details">' +
            '<span>\uD83D\uDCC5 ' + ev.date + '</span>' +
            '<span>\uD83D\uDCCD ' + ev.location + '</span>' +
          '</div>' +
        '</div>'
    )
    .join('');
}

// Projects
function renderProjects() {
  const container = $('#projectsList');
  if (!container) return;
  container.innerHTML = APP_DATA.projects
    .map(
      (p) =>
        '<div class="project-card reveal">' +
          '<div class="project-header">' +
            '<h3 style="font-size:16px">' + p.title + '</h3>' +
            '<span class="project-status ' + (p.status === 'Completed' ? 'status-completed' : 'status-progress') + '">' + p.status + '</span>' +
          '</div>' +
          '<p style="font-size:14px;color:var(--text-secondary);margin-bottom:12px">' + p.description + '</p>' +
          '<div class="progress-bar">' +
            '<div class="progress-fill" style="width:' + (p.progress * 100) + '%"></div>' +
          '</div>' +
          '<div class="project-stats">' +
            '<div class="project-stat">\uD83D\uDC65 ' + p.volunteers + ' volunteers</div>' +
            (p.trees > 0 ? '<div class="project-stat">\uD83C\uDF33 ' + p.trees + ' trees</div>' : '') +
            (p.wasteKg > 0 ? '<div class="project-stat">\u267B\uFE0F ' + p.wasteKg + ' kg waste</div>' : '') +
          '</div>' +
          (p.updates.length
            ? '<div class="project-updates"><h4>Updates</h4><ul>' + p.updates.map((u) => '<li>' + u + '</li>').join('') + '</ul></div>'
            : '') +
        '</div>'
    )
    .join('');
}

// Gallery
let galleryIndex = 0;

function renderGallery() {
  const grid = $('#galleryGrid');
  if (!grid) return;
  const colors = ['#2E7D32', '#1565C0', '#FF8F00', '#4CAF50', '#42A5F5', '#6D4C41'];
  grid.innerHTML = APP_DATA.gallery
    .map(
      (item, i) =>
        '<div class="gallery-item" onclick="openLightbox(' + i + ')">' +
          '<img src="' + item.image + '" alt="' + item.title + '" onerror="this.style.display=\'none\';this.nextElementSibling.style.display=\'flex\'">' +
          '<div class="gallery-placeholder" style="display:none;background:' + colors[i % colors.length] + '22;color:' + colors[i % colors.length] + '">' +
            '<span style="font-size:40px">\uD83D\uDDBC</span>' +
            '<span>' + item.title + '</span>' +
          '</div>' +
          '<div class="overlay">' +
            '<div style="font-size:14px;font-weight:600">' + item.title + '</div>' +
            '<div style="font-size:12px;opacity:0.8">' + item.category + '</div>' +
          '</div>' +
        '</div>'
    )
    .join('');
}

function openLightbox(index) {
  galleryIndex = index;
  const lb = $('#lightbox');
  const item = APP_DATA.gallery[index];
  $('#lightboxImg').src = item.image;
  $('#lightboxCaption').textContent = item.title;
  lb.classList.add('open');
  document.body.style.overflow = 'hidden';
}

function closeLightbox() {
  $('#lightbox').classList.remove('open');
  document.body.style.overflow = '';
}

function lightboxNav(dir) {
  galleryIndex = (galleryIndex + dir + APP_DATA.gallery.length) % APP_DATA.gallery.length;
  const item = APP_DATA.gallery[galleryIndex];
  $('#lightboxImg').src = item.image;
  $('#lightboxCaption').textContent = item.title;
}

// Articles
function renderArticles() {
  const container = $('#articlesList');
  if (!container) return;
  container.innerHTML = APP_DATA.articles
    .map(
      (a) =>
        '<div class="article-card reveal">' +
          '<div class="article-meta">' +
            '<span class="badge badge-category">' + a.category + '</span>' +
            '<span style="font-size:12px;color:var(--text-secondary)">' + a.date + '</span>' +
          '</div>' +
          '<h3>' + a.title + '</h3>' +
          '<p>' + a.summary + '</p>' +
        '</div>'
    )
    .join('');
}

// Team
function renderTeam() {
  const officersEl = $('#officersList');
  const advisersEl = $('#advisersList');
  if (!officersEl || !advisersEl) return;

  const greenColors = ['#2E7D32', '#4CAF50', '#81C784', '#1B5E20', '#43A047', '#66BB6A'];
  officersEl.innerHTML = APP_DATA.officers
    .map(
      (m, i) =>
        '<div class="team-card reveal">' +
          '<div class="avatar" style="background:' + greenColors[i % greenColors.length] + '22;color:' + greenColors[i % greenColors.length] + '">' + m.name.split(' ').map((n) => n[0]).join('') + '</div>' +
          '<div class="team-info"><h4>' + m.name + '</h4><p>' + m.role + '</p></div>' +
          '<span class="team-badge" style="background:rgba(46,125,50,0.1);color:var(--primary-green)">Officer</span>' +
        '</div>'
    )
    .join('');

  advisersEl.innerHTML = APP_DATA.advisers
    .map(
      (m, i) =>
        '<div class="team-card reveal">' +
          '<div class="avatar" style="background:' + ['#1565C0', '#42A5F5'][i] + '22;color:' + ['#1565C0', '#42A5F5'][i] + '">' + m.name.split(' ').map((n) => n[0]).join('') + '</div>' +
          '<div class="team-info"><h4>' + m.name + '</h4><p>' + m.role + '</p></div>' +
          '<span class="team-badge" style="background:rgba(21,101,192,0.1);color:var(--primary-blue)">Adviser</span>' +
        '</div>'
    )
    .join('');
}

// Fun Fact
function renderFunFact() {
  const el = $('#funFact');
  if (!el) return;
  const facts = APP_DATA.funFacts;
  el.querySelector('p').textContent = facts[Math.floor(Math.random() * facts.length)];
}

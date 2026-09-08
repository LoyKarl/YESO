const APP_DATA = {
  stats: {
    treesPlanted: 110,
    projectsCompleted: 3,
    studentVolunteers: 1500,
    outreachActivities: 0,
    wasteCollectedKg: 60,
  },

  events: [
    {
      title: 'Tree Planting',
      description: 'Tree planting activity conducted at the school grounds.',
      date: 'Aug 29, 2026',
      location: 'School Campus',
      category: 'Tree Planting',
      isUpcoming: false,
    },
  ],

  projects: [
    {
      title: 'School Garden Initiative',
      description: 'Creating a sustainable vegetable and herb garden on campus to promote local food production and biodiversity.',
      status: 'In Progress',
      progress: 0.65,
      volunteers: 85,
      trees: 0,
      wasteKg: 0,
      updates: [
        'Raised beds constructed (Apr 2026)',
        'First seedlings planted (May 2026)',
        'Compost system installed (Jun 2026)',
      ],
    },
    {
      title: 'Plastic-Free Campus',
      description: 'Eliminating single-use plastics across all school facilities through bans, alternatives, and awareness campaigns.',
      status: 'Completed',
      progress: 1.0,
      volunteers: 200,
      trees: 0,
      wasteKg: 1500,
      updates: [
        'Bottle refill stations installed (Jan 2026)',
        'Cafeteria switched to biodegradable packaging (Mar 2026)',
        '1,500 kg of plastic waste diverted (Jun 2026)',
      ],
    },
    {
      title: 'Rainwater Harvesting System',
      description: 'Installing rainwater collection systems to irrigate school gardens and reduce water consumption.',
      status: 'In Progress',
      progress: 0.4,
      volunteers: 35,
      trees: 50,
      wasteKg: 0,
      updates: [
        'System design completed (May 2026)',
        'Gutters installed (Jun 2026)',
      ],
    },
    {
      title: 'School-Wide Recycling Program',
      description: 'Comprehensive recycling program with segregated bins, collection schedule, and partnerships with local recyclers.',
      status: 'In Progress',
      progress: 0.8,
      volunteers: 150,
      trees: 0,
      wasteKg: 3000,
      updates: [
        'Bin stations deployed in all buildings (Feb 2026)',
        'Monthly collection started (Mar 2026)',
        '3,000 kg recycled to date (Jun 2026)',
      ],
    },
    {
      title: 'Energy Conservation Campaign',
      description: "Reducing the school's carbon footprint through energy-efficient lighting, solar panels, and conservation awareness.",
      status: 'Completed',
      progress: 1.0,
      volunteers: 60,
      trees: 0,
      wasteKg: 0,
      updates: [
        'LED retrofitting completed (Dec 2025)',
        'Solar panels installed on roof (Feb 2026)',
        '30% reduction in energy consumption (Apr 2026)',
      ],
    },
  ],

  officers: [
    { name: 'Maria Santos', role: 'President' },
    { name: 'Jose Cruz', role: 'Vice President' },
    { name: 'Ana Reyes', role: 'Secretary' },
    { name: 'Carlos Lim', role: 'Treasurer' },
    { name: 'Diana Chen', role: 'Auditor' },
    { name: 'Mark Garcia', role: 'P.R.O.' },
  ],

  advisers: [
    { name: 'Dr. Emilia Ramos', role: 'Adviser' },
    { name: 'Mr. Ricardo Torres', role: 'Co-Adviser' },
  ],

  articles: [
    {
      title: "Understanding Climate Change: A Student's Guide",
      category: 'Climate Change',
      summary: 'Learn the science behind global warming and how young people can take meaningful action.',
      date: 'Jan 2026',
    },
    {
      title: 'The Amazing Biodiversity of the Philippines',
      category: 'Biodiversity',
      summary: 'Discover why the Philippines is a megadiverse country and what species are at risk.',
      date: 'Feb 2026',
    },
    {
      title: 'Waste Management 101: Reduce, Reuse, Recycle',
      category: 'Waste Management',
      summary: 'Practical tips for managing waste at home and in school.',
      date: 'Mar 2026',
    },
    {
      title: 'Renewable Energy: Powering a Sustainable Future',
      category: 'Renewable Energy',
      summary: 'Explore solar, wind, and hydro power and how they can replace fossil fuels.',
      date: 'Apr 2026',
    },
    {
      title: 'Conservation Strategies for Local Ecosystems',
      category: 'Conservation',
      summary: 'How student-led efforts can protect forests, rivers, and coastal areas.',
      date: 'May 2026',
    },
    {
      title: 'Filipino Scientists Making a Difference',
      category: 'Scientific Innovations',
      summary: 'Meet the Filipino innovators whose discoveries are shaping environmental science.',
      date: 'Jun 2026',
    },
  ],

  gallery: [
    { title: 'Tree Planting Aug 29 - Photo 1', category: 'Tree Planting', image: 'assets/images/f2da42ac-8b89-45ea-be5a-3fdb77de222c.jpg' },
    { title: 'Tree Planting Aug 29 - Photo 2', category: 'Tree Planting', image: 'assets/images/1e7893e3-8830-40a9-b443-df77dd61fd05.jpg' },
    { title: 'Tree Planting Aug 29 - Photo 3', category: 'Tree Planting', image: 'assets/images/150783c1-0738-46cb-8515-b071d0ff688e (1).jpg' },
    { title: 'Tree Planting Aug 29 - Photo 4', category: 'Tree Planting', image: 'assets/images/0511e8a0-a362-4e3e-bbc4-d0f8bd048c5a.jpg' },
  ],

  milestones: [
    { year: '2018', event: 'YES-O Club founded at Belison National Science High School' },
    { year: '2019', event: 'First tree planting event with 200 participants' },
    { year: '2020', event: 'Launched online environmental awareness campaigns' },
    { year: '2021', event: 'Won Regional Science & Environment Competition' },
    { year: '2022', event: 'Expanded to 500+ active members' },
    { year: '2023', event: 'Implemented school-wide recycling program' },
  ],

  funFacts: [
    'A single tree can absorb up to 48 pounds of CO\u2082 per year!',
    'The Philippines is home to over 200 species of mammals and 600 species of birds.',
    'Recycling one aluminum can saves enough energy to power a TV for 3 hours.',
    'Plastic takes up to 450 years to decompose in the ocean.',
    'Solar energy is the most abundant energy source on Earth.',
    'Over 80% of marine pollution comes from land-based activities.',
    'Bamboo grows faster than any other plant on the planet.',
    'Coral reefs support 25% of all marine species.',
  ],
};

<template>
  <div class="project-list">
    <h1>大島智彦のポートフォリオ</h1>
    <h2>Rails + Vue.js + Docker</h2>
    <p>こちらをご覧くださって誠にありがとうございます。今回の募集に合わせて、取り急ぎ作成したアプリケーションになります。</p>
    <p>これまで{{ yearsOfExperience }}年以上の現場経験を積み、主にRuby on RailsとJavaScript(Vue.jsなど)を用いて開発を行ってきました。</p>
    <p>※以下はあくまでポートフォリオのアプリケーションとしての簡単な概要の表示になりますので、スキルの詳細は<a :href="skillSheetUrl" target="_blank" rel="noopener noreferrer" class="skill-sheet-link">スキルシート</a>をぜひご覧ください。</p>
    <h2>これまで参画したプロジェクト一覧</h2>
    <div v-if="loading" class="loading">Loading projects...</div>
    <div v-if="error" class="error">{{ error }}</div>
    <ul v-if="projects.length > 0">
      <li v-for="project in projects" :key="project.id">
        <h3>{{ project.title }}</h3>
        <p>{{ project.description }}</p>
        <img v-if="project.image_url" :src="`http://localhost:3000${project.image_url}`" alt="Project Image" style="max-width: 200px;" />
        <p><strong>役割:</strong> {{ project.role }}</p>
        <p><strong>期間:</strong> {{ formatDate(project.start_date) }} - {{ formatDate(project.end_date) }} {{ calculateDuration(project.start_date, project.end_date) }}</p>
        <div v-if="project.technologies && project.technologies.length > 0">
          <strong>技術スタック:</strong> {{ project.technologies.map(tech => tech.name).join(', ') }}
        </div>
      </li>
    </ul>
    <div v-else-if="!loading && projects.length === 0">
      参加したプロジェクトはありません。
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, computed } from 'vue';

const skillSheetUrl = computed(() => process.env.VUE_APP_SKILL_SHEET_URL || '#'); // Fallback to '#' if not set
import axios from 'axios';

const projects = ref([]);
const loading = ref(true);
const error = ref(null);

const formatDate = (dateString) => {
  if (!dateString) return '';
  try {
    const date = new Date(dateString);
    if (isNaN(date.getTime())) {
      return '不正な値です';
    }
    const year = date.getFullYear();
    const month = date.getMonth() + 1;
    return `${year}年${month}月`;
  } catch (e) {
    console.error('Error formatting date:', dateString, e);
    return '不正な値です';
  }
};

const calculateDuration = (startDateString, endDateString) => {
  if (!startDateString || !endDateString) return '';
  try {
    const startDate = new Date(startDateString);
    const endDate = new Date(endDateString);

    if (isNaN(startDate.getTime()) || isNaN(endDate.getTime()) || startDate > endDate) {
      return '';
    }

    let totalMonths = (endDate.getFullYear() - startDate.getFullYear()) * 12 + (endDate.getMonth() - startDate.getMonth()) + 1;

    if (totalMonths <= 0) return '';

    const years = Math.floor(totalMonths / 12);
    const monthsInYear = totalMonths % 12;

    let durationParts = [];
    if (years > 0) {
      durationParts.push(`${years}年`);
    }
    if (monthsInYear > 0) {
      durationParts.push(`${monthsInYear}ヶ月`);
    }
    
    return durationParts.length > 0 ? `(${durationParts.join('')})` : '';

  } catch (e) {
    console.error('Error calculating duration:', startDateString, endDateString, e);
    return '';
  }
};

const yearsOfExperience = computed(() => {
  if (!projects.value || projects.value.length === 0) {
    return '0';
  }

  let earliestStartDate = null;
  for (const project of projects.value) {
    if (project.start_date) {
      const currentProjectStartDate = new Date(project.start_date);
      if (!isNaN(currentProjectStartDate.getTime())) {
        if (!earliestStartDate || currentProjectStartDate < earliestStartDate) {
          earliestStartDate = currentProjectStartDate;
        }
      }
    }
  }

  if (!earliestStartDate) {
    return 'X';
  }

  const today = new Date();
  let years = today.getFullYear() - earliestStartDate.getFullYear();
  const monthDiff = today.getMonth() - earliestStartDate.getMonth();
  if (monthDiff < 0 || (monthDiff === 0 && today.getDate() < earliestStartDate.getDate())) {
    years--;
  }
  return Math.max(0, years);
});

const fetchProjects = async () => {
  try {
    const response = await axios.get('http://localhost:3000/api/v1/projects');
    projects.value = response.data;
  } catch (err) {
    console.error('Error fetching projects:', err);
    error.value = 'Failed to load projects. Please try again later.';
  }
  loading.value = false;
};

onMounted(() => {
  fetchProjects();
});
</script>

<style scoped>
.skill-sheet-link {
  font-weight: bold;
  color: red;
  font-size: 1.5em;
}

.project-list {
  font-family: sans-serif;
  max-width: 800px;
  margin: 20px auto;
  padding: 20px;
  background-color: #f9f9f9;
  border-radius: 8px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.project-list h1, .project-list h2 {
  text-align: center;
  color: #333;
  margin-bottom: 20px;
}

.project-list ul {
  list-style-type: none;
  padding: 0;
}

.project-list li {
  background-color: #fff;
  border: 1px solid #ddd;
  padding: 15px;
  margin-bottom: 15px;
  border-radius: 4px;
}

.project-list h3 {
  margin-top: 0;
  color: #007bff;
}

.project-list p {
  margin-bottom: 10px;
  line-height: 1.6;
}

.project-list strong {
  color: #555;
}

.project-list img {
  display: block;
  margin-bottom: 10px;
  border-radius: 4px;
}

.loading,
.error {
  text-align: center;
  padding: 20px;
  font-size: 1.2em;
}

.error {
  color: red;
}
</style>

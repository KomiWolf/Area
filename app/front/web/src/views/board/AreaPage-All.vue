<template>
  <div class="explore-page">
    <AppHeader />
    <Header />
    <section class="title-section">
      <h1 class="section-title">My Applets</h1>
      <!-- <div class="filter-buttons">
        <router-link to="/explore/all" class="filter-btn active" :class="{ active: $route.path === '/explore/all' }">All</router-link>
        <router-link to="/explore/applets" class="filter-btn" :class="{ active: $route.path === '/explore/applets' }">Applets</router-link>
        <router-link to="/explore/services" class="filter-btn" :class="{ active: $route.path === '/explore/services' }">Services</router-link>
      </div> -->
    </section>
    <div class="search-section">
      <input
        type="text"
        class="search-bar"
        placeholder="Search an applet"
        v-model="searchQuery"
      />
      <button class="clear-search" @click="clearSearchQuery">✖</button>
    </div>
    <section class="applets-section">
      <div class="applets-container">
        <div class="applets-grid" ref="appletsGrid">
          <template v-for="(item, index) in filteredAllItems" :key="index">
            <!-- Vérification du type pour afficher le composant approprié -->
            <AppletTile
              :id="item.id"
              :title="item.name"
              :background-color="item.colour"
              :description="item.description"
            />
            <!-- <ServiceTile
              v-else-if="item.type === 'service'"
              :title="item.title"
              :background-color="item.color"
            /> -->
          </template>
        </div>
      </div>
    </section>
  </div>
</template>

<script lang="ts">
import { defineComponent, ref, computed, onBeforeMount } from 'vue';
// import { useStore } from 'vuex';
import Header from '@/components/AppHeader.vue';
import AppletTile from '@/components/AppletBoardTile.vue';
import { queries } from '@/../lib/querier';
// import ServiceTile from '@/components/ServiceBoardTile.vue';

export default defineComponent({
  components: {
    Header,
    AppletTile,
    // ServiceTile,
  },
  setup() {
    const searchQuery = ref("");
    const applets = ref<any[]>([]);

    const clearSearchQuery = () => {
      searchQuery.value = "";
    };

    const filteredAllItems = computed(() =>
      !searchQuery.value
        ? applets.value
        : applets.value.filter((applet) => {
            const searchWords = searchQuery.value.toLowerCase().split(' ').filter(word => word.length > 0);
            const matchesName = searchWords.some(word =>
              applet.name.toLowerCase().includes(word)
            );
            const matchesTags = searchWords.some(word =>
              applet.tags.toLowerCase().split(' ').some((tag: string) => tag.includes(word))
            );
            return matchesName || matchesTags;
          })
    );

    onBeforeMount(async () => {
      try {
        const token = localStorage.getItem("authToken") || "";
        const response = await queries.get("/api/v1/my_applets", {}, token);
        if (response.resp === "success") {
          applets.value = response.msg;
        }
      } catch (error) {
        console.error("Error when retrieving triggers:", error);
      }
    });

    return {
      searchQuery,
      applets,
      clearSearchQuery,
      filteredAllItems,
    };
  },
});
</script>

<style scoped>
.explore-page {
  font-family: 'Arial', sans-serif;
  padding: 0 2%;
  background-color: transparent;
  padding-top: 80px;
}

.filter-btn.active {
  font-weight: bold;
}

.filter-buttons {
  display: flex;
  justify-content: center;
  flex-wrap: wrap;
  margin-bottom: 20px;
}

.filter-btn {
  background-color: transparent;
  border: none;
  color: black;
  font-size: 1rem;
  margin: 0 5px;
  padding: 8px 15px;
  cursor: pointer;
}

.filter-btn:hover {
  text-decoration: underline;
}

.search-section {
  display: flex;
  justify-content: center;
  align-items: center;
  margin: 20px 0;
}

.search-bar {
  width: 90%;
  max-width: 600px;
  padding: 12px;
  border: 1px solid #ccc;
  border-radius: 25px;
  font-size: 1rem;
  text-align: center;
}

.clear-search {
  background: none;
  border: none;
  cursor: pointer;
  margin-left: -35px;
  font-size: 18px;
}

.applets-section {
  text-align: center;
}

.applets-container {
  display: flex;
  justify-content: center;
  align-items: center;
}

.applets-grid {
  display: grid;
  gap: 20px;
  padding: 20px 0;
  max-width: 100%;
}

.applet-tile {
  width: 100%;
  max-width: 300px;
  height: auto;
  padding: 20px;
  border-radius: 15px;
  text-align: center;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  font-family: 'Arial', sans-serif;
}

.applet-title {
  font-size: 20px;
  font-weight: bold;
  margin-bottom: 15px;
  color: #333;
}

.applet-description {
  font-size: 16px;
  color: #666;
  line-height: 1.5;
}

.title-section {
  text-align: center;
  margin: 30px 0;
}

.section-title {
  font-size: 36px;
  font-weight: bold;
  margin-bottom: 10px;
}

@media (min-width: 1200px) {
  .applets-grid {
    grid-template-columns: repeat(4, 1fr);
  }
}

@media (min-width: 992px) and (max-width: 1199px) {
  .applets-grid {
    grid-template-columns: repeat(3, 1fr);
  }
}

@media (min-width: 768px) and (max-width: 991px) {
  .applets-grid {
    grid-template-columns: repeat(2, 1fr);
  }
}

@media (max-width: 767px) {
  .applets-grid {
    grid-template-columns: 1fr;
  }

  .section-title {
    font-size: 2rem;
  }

  .search-bar {
    width: 80%;
  }

  .filter-btn {
    font-size: 0.9rem;
    padding: 5px 10px;
  }
}
</style>

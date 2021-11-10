<template>
  <div>
    <div>
      <SearchBox />
    </div>
    <div class="categories">
      <div v-for="category in categories" :key="category" class="category">
        <h2>{{ category }}</h2>
        <ul>
          <li v-for="post in postsFilteredByCategory(category)" :key="post.key">
            <router-link class="title" :to="post.path">
              {{ post.title }}
            </router-link>
          </li>
        </ul>
      </div>
    </div>
  </div>
</template>

<script>
import SearchBox from "@SearchBox";

export default {
  components: { SearchBox },
  props: {
    pages: Array,
  },
  data() {
    return {
      sortedPages: [],
    };
  },
  computed: {
    categories() {
      const categories = [
        ...new Set(this.sortedPages.map((page) => page.frontmatter.category)),
      ];
      return categories;
    },
  },
  methods: {
    fillPosts() {
      for (let page of this.$props.pages) {
        if (!page.frontmatter.category) {
          page.frontmatter.category = "uncategorized";
        }
        this.sortedPages.push(page);
      }
    },
    postsFilteredByCategory(category) {
      return this.sortedPages.filter(
        (page) =>
          page.frontmatter.category == category && !page.frontmatter.home
      );
    },
  },
  mounted() {
    this.fillPosts();
  },
};
</script>

<style>
.categories {
  display: flex;
  flex-wrap: wrap;
  flex-direction: row;
}

.category {
  flex: 1 0 20%;
  margin: 20px;
}
ul {
  list-style-type: none;
  padding-left: 0;
}
</style>